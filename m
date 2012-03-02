From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Mar 2012 22:09:04 +0000
Subject: [PATCH v2 0/6] ARM: Tegra: cleanup patches from Arnd Bergmann
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF17BE861A73@HQMAIL01.nvidia.com>
References: <1330721884-8495-1-git-send-email-alan@signal11.us>
 <4F513DE3.9020707@signal11.us>
 <74CDBE0F657A3D45AFBB94109FB122FF17BE861A73@HQMAIL01.nvidia.com>
Message-ID: <201203022209.04419.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012, Stephen Warren wrote:
> > For patch #5 (ARM: tegra: USB_ULPI needs USB), it didn't look to me like
> > there was a resolution on that thread yesterday. On reading it again, if
> > we change
> >     select USB_ULPI if USB_SUPPORT
> > to:
> >     select USB_ULPI if USB
> > for both Tegra 2 and 3, does that satisfy you and Arnd?
> 
> I believe so yes. Thanks.

Agreed.

	Arnd
