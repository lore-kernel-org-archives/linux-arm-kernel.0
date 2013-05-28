From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 27 May 2013 23:10:56 -0400 (EDT)
Subject: VDSO for arm 32bit
In-Reply-To: <634BB1CFA60ED14386C17849392C3EB202E52C9C0A@HICGWSEX01.ad.harman.com>
References: <634BB1CFA60ED14386C17849392C3EB202E52C9C0A@HICGWSEX01.ad.harman.com>
Message-ID: <alpine.LFD.2.03.1305272307340.1918@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 May 2013, Kumar, Ganesh wrote:

> Hi All,
> 
> ? I'm working on OMAP5 on greg's LTS kernel 3.4.25, but I see there is
> no support for vdso for arm 32 bit.
> I'm planning to port it to arm 32 bit, is there any work under progress?
> would like to understand why the support for arm 32 bit is not there, any idea?

Please have a look at Documentation/arm/kernel_user_helpers.txt.


Nicolas
