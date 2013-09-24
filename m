From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 24 Sep 2013 17:59:25 +0200
Subject: [PATCH 1/4] i2c: busses: i2c-st: Add ST I2C controller
In-Reply-To: <5241B1FA.6020500@st.com>
References: <1379498483-4236-1-git-send-email-maxime.coquelin@st.com>
 <1379498483-4236-2-git-send-email-maxime.coquelin@st.com>
 <5240AD6E.4090905@wwwdotorg.org> <5241B1FA.6020500@st.com>
Message-ID: <20130924155925.GA2995@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> "glitch" is is used to tune the I2C timing requirements, and has a 
> nanosecond granularity.
> These values are added to default timing values.
> I'm not 100% sure, but it looks like the "samsung,i2c-sda-delay" in the 
> i2c-s3c2410 driver.

For that, we have the generic "i2c-sda-hold-time-ns" property. The s3c
driver hasn't been converted to use it, sadly.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130924/9c8288cb/attachment.sig>
