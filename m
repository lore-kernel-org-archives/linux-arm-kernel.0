From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 3 Apr 2015 20:17:46 +0200
Subject: [PATCH v3 1/4] i2c: mux-pinctrl: Rework to honor disabled child
 nodes
In-Reply-To: <5515C6B6.7080903@gmail.com>
References: <550A05E5.3050100@gmail.com> <20150319100944.GA914@katana>
 <550AEF9D.6090307@wwwdotorg.org> <20150319160208.GF7657@katana>
 <550B3725.10209@gmail.com> <20150320101925.GC2071@katana>
 <20150321210028.GA1078@katana> <550EBDBC.9000903@gmail.com>
 <20150323183211.GB1128@katana> <5515C6B6.7080903@gmail.com>
Message-ID: <20150403181746.GA1298@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> While thinking about it (and I still think of it as a 'big issue'
> compared to the intention of the initial patch) I came to the
> conclusion that I should maybe just go for a board-specific
> i2c-mux-pinctrl node instead of adding it to the SoC dtsi. That will
> also avoid doubled i2c busses on boards with just the default i2c
> option.

Ehrm, then please let me know what you decided on. If you chose the
above road, then I don't need to think about the other questions :)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150403/6c78355c/attachment.sig>
