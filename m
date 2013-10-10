From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 10 Oct 2013 12:03:54 +0200
Subject: [PATCH v4 0/4] Add I2C support to ST SoCs
In-Reply-To: <525675B6.4080404@st.com>
References: <1381250576-7916-1-git-send-email-maxime.coquelin@st.com>
 <525675B6.4080404@st.com>
Message-ID: <20131010100354.GE2638@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Changes since v3:
> >    - Switch back to vendor specific DT properties regarding the anti-glitch
> >      filter configuration, as this IP is the only one having such a filter.
> Do you agree to keep these properties vendor-specifics?

My preference is generic bindings. There are no other users right now,
yet there might be in the future. At least with something similar enough
that the bindings will apply. Was hoping for some additional input,
though, but I am not depending on it.

> If so, could you take this series for v3.13?

Sure, if it passes the second review...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131010/64289c85/attachment.sig>
