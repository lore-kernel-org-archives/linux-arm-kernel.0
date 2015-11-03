From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 03 Nov 2015 11:48:38 +0100
Subject: [PATCH v2 2/5] mfd: ts4800-syscon: add driver for TS-4800 syscon
In-Reply-To: <20151103101217.GE3503@x1>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <4911273.Q2mbQ2gvpn@wuerfel> <20151103101217.GE3503@x1>
Message-ID: <5597828.MPo2kL1TSa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 November 2015 10:12:17 Lee Jones wrote:
> > 
> > I think a 'buswidth=<16>;' property in addition to 'compatible="syscon"'
> > is more in line with what other subsystems do.
> 
> Perfect.
> 

Just to clarify: I just checked the other DT bindings and it should
actually be "bus-width", not "buswidth".

	Arnd
