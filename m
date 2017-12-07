From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 7 Dec 2017 11:52:29 +0100
Subject: [PATCH] i2c: stm32: Fixes multibyte transfer for STM32F4 I2C
 controller
In-Reply-To: <CAFvLkMTsgxpjoGRgq7J0NFkT=YsOTYL6smkVhOPcfD=26Hzutg@mail.gmail.com>
References: <1507722788-31224-1-git-send-email-radoslaw.pietrzyk@gmail.com>
 <990c3275-35b3-68da-453c-d1a80e867df7@st.com>
 <CAFvLkMS6+o3D88Rj23of56KtjonwFAVD_aEP3eWaA2H=U5WP4Q@mail.gmail.com>
 <2d892fec-0496-8a6f-51c9-439b933d9975@st.com>
 <CAFvLkMS9Q801biCBYp+fJeiOo22zr436Td43PH3GG8E6diSL3A@mail.gmail.com>
 <b24d9699-a88d-6a83-ceaf-140ea8b4db97@st.com>
 <CAFvLkMTsgxpjoGRgq7J0NFkT=YsOTYL6smkVhOPcfD=26Hzutg@mail.gmail.com>
Message-ID: <20171207105229.jxxyfofsgub27nip@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 01:45:43PM +0200, Rados?aw Pietrzyk wrote:
> I'm afraid that didn't help and the problem still exists even with
> those patches applied.

So, my reading is: There is an issue which needs to be investigated?
Does applying the patch make sense until the issue is fully understood?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/c3624399/attachment.sig>
