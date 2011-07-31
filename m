From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 31 Jul 2011 02:27:38 +0200
Subject: [PATCH 11/18] dmaengine/amba-pl08x: max_bytes_per_lli is
	TRANSFER_SIZE * src_width (not MIN(width))
In-Reply-To: <5521ee74eef41cf26a9f1ece6dadd32cca529cce.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<5521ee74eef41cf26a9f1ece6dadd32cca529cce.1311936524.git.viresh.kumar@st.com>
Message-ID: <CAKnu2MpUj9JDDg8psPf5WaGGFSZGmPcmtiujKiFzcHM71RqLKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/29 Viresh Kumar <viresh.kumar@st.com>:

> max_bytes_per_lli = bd.srcbus.buswidth * PL080_CONTROL_TRANSFER_SIZE_MASK;
> This is confirmed by ARM support guys.

Great and THANKS for your tiresome research in ironing out the ambiguities
in the manuals.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
