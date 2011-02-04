From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 03 Feb 2011 21:02:45 -0500 (EST)
Subject: [PATCH 0/2] Allow using machine ID for DEBUG_LL macros
In-Reply-To: <20110204012008.26298.16341.stgit@baageli.muru.com>
References: <20110204012008.26298.16341.stgit@baageli.muru.com>
Message-ID: <alpine.LFD.2.00.1102032057070.12104@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Feb 2011, Tony Lindgren wrote:

> Hi all,
> 
> Here are two patches that allow using machine ID for DEBUG_LL
> macros by adding a new macro inituart.

This won't work with the device tree support as the machine ID is then 
replaced with a catch-it-all-with-dt-support machine ID.


Nicolas
