From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 21 Nov 2013 14:14:02 +0100
Subject: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
In-Reply-To: <528DF164.8060009@st.com>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <528DF164.8060009@st.com>
Message-ID: <20131121131402.GF1029@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Thu, Nov 21, 2013 at 12:41:24PM +0100, Denis CIOCCA wrote:
> only one point: it's possible to use the same names with DT? (using _ 
> instead of -)

Yes, it is, but only for i2c as far as I'm aware, and usually the DT
compatibles are with - as a separator (I looked into the ePAPR, but
couldn't get any explanations or requirements on this, even though
it's used in all of their examples)

> Why only for i2c?

Because I was only interested in i2c :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131121/88174551/attachment.sig>
