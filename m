From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 26 Mar 2018 10:00:50 +0200
Subject: [PATCH v2 1/6] i2c: i2c-stm32f7: Add 10-bit address support
In-Reply-To: <fd463a3d-354c-d4e9-16a8-2829ccc04adc@st.com>
References: <1521650940-11651-1-git-send-email-pierre-yves.mordret@st.com>
 <1521650940-11651-2-git-send-email-pierre-yves.mordret@st.com>
 <20180324224332.apsixpklrgtelak7@ninjato>
 <fd463a3d-354c-d4e9-16a8-2829ccc04adc@st.com>
Message-ID: <20180326080049.lgg4fxcmdav7h766@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Out of curiosity: how did you test this patch? I never managed to find a
> > 10-bit client (except for an SoC with 10-bit slave mode).
> 
> I don't have a 10-bit device either. For testing 10-bit I'm using 2 I2C
> instances from the SoC, one in master mode and the other in slave mode.

Nice!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180326/ccc74ff9/attachment.sig>
