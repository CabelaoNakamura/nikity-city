(this.webpackJsonpcrp_chars = this.webpackJsonpcrp_chars || []).push([
    [0], {
        58: function(e, t, a) {
            e.exports = a(69)
        },
        63: function(e, t, a) {},
        67: function(e, t, a) {},
        69: function(e, t, a) {
            "use strict";
            a.r(t);
            var n = a(0),
                r = a.n(n),
                c = a(9),
                l = a(24),
                o = (a(63), a(98)),
                s = a(49),
                i = a(102),
                u = function() {
                    return r.a.createElement(o.a, {
                        className: "landingContainer",
                        maxWidth: !1
                    }, r.a.createElement("div", {
                        className: "container"
                    }, r.a.createElement(i.a, {
                        className: "spinner"
                    })))
                },
                m = a(21),
                d = (a(67), a(103)),
                p = a(104),
                f = a(105),
                E = a(106),
                h = a(107),
                y = a(114),
                b = a(108),
                v = a(109),
                C = a(112),
                g = a(115),
                x = a(110),
                N = a(111),
                O = function(e) {
                    var t = Object(n.useState)({
                            openCreate: !1,
                            sex: "",
                            openDelete: "",
                            selected: null
                        }),
                        a = Object(l.a)(t, 2),
                        c = a[0],
                        i = a[1],
                        u = Object(n.useState)(""),
                        O = Object(l.a)(u, 2),
                        j = O[0],
                        S = O[1],
                        T = Object(n.useState)(""),
                        P = Object(l.a)(T, 2),
                        k = P[0],
                        w = P[1],
                        D = function() {
                            i((function(e) {
                                return Object(m.a)({}, e, {
                                    openCreate: !0
                                })
                            }))
                        },
                        q = function() {
                            i((function(e) {
                                return Object(m.a)({}, e, {
                                    openCreate: !1,
                                    sex: ""
                                })
                            })), S(""), w("")
                        },
                        W = function() {
                            i((function(e) {
                                return Object(m.a)({}, e, {
                                    openDelete: !1
                                })
                            }))
                        };
                    return r.a.createElement("div", {
                        className: "background"
                    }, r.a.createElement(o.a, {
                        maxWidth: !1,
                        className: "container"
                    }, [0, 1, 2, 3].map((function(t) {
                        return void 0 !== e.chars[t] ? r.a.createElement(d.a, {
                            elevation: 3,
                            className: "card"
                        }, r.a.createElement(p.a, {
                            className: "content"
                        }, r.a.createElement(s.a, {
                            variant: "subtitle1",
                            className: "text titleText"
                        }, "#".concat(e.chars[t].id, " ").concat(e.chars[t].name, " ").concat(e.chars[t].name2)), r.a.createElement(f.a, null), r.a.createElement(E.a, {
                            className: "actions"
                        }, r.a.createElement(h.a, {
                            variant: "contained",
                            fullWidth: !0,
                            className: "buttons",
                            color: "secondary",
                            onClick: function() {
                                return function(e) {
                                    i((function(t) {
                                        return Object(m.a)({}, t, {
                                            openDelete: !0,
                                            selected: e
                                        })
                                    }))
                                }(t)
                            }
                        }, "Deletar"), r.a.createElement(h.a, {
                            variant: "contained",
                            fullWidth: !0,
                            className: "buttons",
                            color: "primary",
                            onClick: function() {
                                return function(t) {
                                    return e.play(t)
                                }(t)
                            }
                        }, "Entrar")))) : r.a.createElement(d.a, {
                            elevation: 3,
                            className: "card empty",
                            onClick: D
                        }, r.a.createElement(p.a, {
                            className: "content"
                        }, r.a.createElement(s.a, {
                            variant: "subtitle1",
                            className: "text titleText"
                        }, "+"), r.a.createElement(s.a, {
                            variant: "body1",
                            className: "text bodyText"
                        }, "Criar Personagem")))
                    }))), r.a.createElement(y.a, {
                        PaperProps: {
                            square: !0
                        },
                        open: c.openCreate,
                        onClose: q
                    }, r.a.createElement("form", {
                        onSubmit: function(t) {
                            t.preventDefault(), e.submit(j, k, c.sex), i((function(e) {
                                return Object(m.a)({}, e, {
                                    openCreate: !1,
                                    sex: ""
                                })
                            })), S(""), w("")
                        }
                    }, r.a.createElement(b.a, null, "Criando Novo Personagem"), r.a.createElement(f.a, null), r.a.createElement(v.a, null, r.a.createElement(C.a, {
                        margin: "dense",
                        label: "Nome",
                        type: "text",
                        inputProps: {
                            maxLength: 15
                        },
                        value: j,
                        onChange: function(e) {
                            return S(e.target.value)
                        },
                        required: !0,
                        fullWidth: !0
                    }), r.a.createElement(C.a, {
                        margin: "dense",
                        label: "Sobrenome",
                        type: "text",
                        inputProps: {
                            maxLength: 15
                        },
                        value: k,
                        onChange: function(e) {
                            return w(e.target.value)
                        },
                        required: !0,
                        fullWidth: !0
                    }), r.a.createElement(C.a, {
                        margin: "dense",
                        label: "G\xeanero",
                        type: "text",
                        value: c.sex,
                        onChange: function(e) {
                            return i((function(t) {
                                return Object(m.a)({}, t, {
                                    sex: e.target.value
                                })
                            }))
                        },
                        select: !0,
                        required: !0,
                        fullWidth: !0
                    }, [{
                        value: "M",
                        display: "Masculino"
                    }, {
                        value: "F",
                        display: "Feminino"
                    }].map((function(e) {
                        return r.a.createElement(g.a, {
                            key: e.value,
                            value: e.value
                        }, e.display)
                    })))), r.a.createElement(x.a, {
                        className: "dialogActions"
                    }, r.a.createElement(h.a, {
                        onClick: q,
                        color: "secondary"
                    }, "Cancelar"), r.a.createElement(h.a, {
                        disabled: "" === j || "" === k || "" === c.sex,
                        type: "submit",
                        color: "primary"
                    }, "Confirmar")))), r.a.createElement(y.a, {
                        PaperProps: {
                            square: !0
                        },
                        open: c.openDelete,
                        onClose: W
                    }, r.a.createElement(b.a, null, "Deletando Personagem"), r.a.createElement(f.a, null), r.a.createElement(v.a, null, r.a.createElement(N.a, null, "Tem certeza que quer deletar o personagem? Essa a\xe7\xe3o \xe9 irrevers\xedvel.")), r.a.createElement(x.a, {
                        className: "dialogActions"
                    }, r.a.createElement(h.a, {
                        onClick: W,
                        color: "secondary"
                    }, "Cancelar"), r.a.createElement(h.a, {
                        onClick: function() {
                            null !== c.selected && e.delete(c.selected), i((function(e) {
                                return Object(m.a)({}, e, {
                                    openDelete: !1
                                })
                            }))
                        },
                        color: "secondary"
                    }, "Deletar"))))
                },
                j = function() {
                    var e = Object(n.useState)(!1),
                        t = Object(l.a)(e, 2),
                        a = t[0],
                        c = t[1],
                        o = Object(n.useState)([]),
                        s = Object(l.a)(o, 2),
                        i = s[0],
                        m = s[1],
                        d = function(e) {
                            void 0 !== e && "show" === e.data.action && (document.getElementById("App").style.display = "block", fetch("http://spawn/GetCharacters", {
                                headers: {
                                    "Content-Type": "application/json"
                                },
                                method: "POST",
                                body: JSON.stringify({})
                            }).then((function(e) {
                                return e.json()
                            })).then((function(e) {
                                m(e), c(!0)
                            })))
                        };
                    return Object(n.useEffect)((function() {
                        return window.addEventListener("message", d),
                            function() {
                                window.removeEventListener("message", d)
                            }
                    }), []), r.a.createElement("div", {
                        id: "App",
                        style: {
                            display: "none"
                        }
                    }, !a && r.a.createElement(u, null), a && r.a.createElement(O, {
                        delete: function(e) {
                            c(!1), fetch("http://spawn/DeleteCharacter", {
                                headers: {
                                    "Content-Type": "application/json"
                                },
                                method: "POST",
                                body: JSON.stringify({
                                    id: i[e].id
                                })
                            }).then((function(e) {
                                return e.json()
                            })).then((function(e) {
                                m(e), c(!0)
                            }))
                        },
                        submit: function(e, t, a) {
                            document.getElementById("App").style.display = "none", fetch("http://spawn/CharacterCreated", {
                                headers: {
                                    "Content-Type": "application/json"
                                },
                                method: "POST",
                                body: JSON.stringify({
                                    name: e,
                                    name2: t,
                                    sex: a
                                })
                            })
                        },
                        play: function(e) {
                            document.getElementById("App").style.display = "none", fetch("http://spawn/CharacterChosen", {
                                headers: {
                                    "Content-Type": "application/json"
                                },
                                method: "POST",
                                body: JSON.stringify({
                                    id: i[e].id
                                })
                            })
                        },
                        chars: i
                    }))
                };
            a(68);
            Object(c.render)(r.a.createElement(j, null), document.getElementById("root"))
        }
    },
    [
        [58, 1, 2]
    ]
]);
//# sourceMappingURL=main.8d868e82.chunk.js.map