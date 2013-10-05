From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 5 Oct 2013 11:24:20 -0300
Subject: IMX6 USDHC card detection
In-Reply-To: <20131005092000.GL2734@S2101-09.ap.freescale.net>
References: <20131003193623.GF12758@n2100.arm.linux.org.uk>
 <CAOMZO5DrdXpWuULubSjSw7fhCm40JiXnVZwu=YMjzX1sW_tuuw@mail.gmail.com>
 <20131005092000.GL2734@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5C1fXaUHOh2yi7AAUFD+vb6mftzaTfiHVsMJcJOdZWP=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 5, 2013 at 6:20 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

> I guess you are not using the controller internal card detection at all
> in this case, because pad NANDF_D0 has no function of any SD_CD_B.  The
> card detection may just happen to work via DAT3 (D3CD).  But same as

Yes, this is what I meant: card detection via DAT3.
