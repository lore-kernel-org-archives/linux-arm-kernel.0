From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 24 Nov 2016 10:34:27 +0100
Subject: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD Host
 Controller
In-Reply-To: <877f7tmduw.fsf@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <4031579.CBE32NHUoW@wuerfel> <877f7tmduw.fsf@free-electrons.com>
Message-ID: <28082657.RK5ubAe11Q@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, November 24, 2016 10:22:31 AM CET Gregory CLEMENT wrote:
> 
> I don't have an option for mmc in general, but using child node do not
> fit at all the xenon controller.
> 
> For this controller each slot has its own set of register, so there is
> no common ressource to share so no advantage to use it. Using child node
> in our case will just make the code more complex for no benefit.

If every slot has its own registers, what is it that makes up the
'controller'? It sounds to me that you just have to adjust the terminology
and talk about multiple controllers then, with one slot per controller.

	Arnd
