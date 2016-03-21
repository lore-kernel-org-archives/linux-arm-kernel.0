From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Mar 2016 18:02:54 +0100
Subject: [RFC5 PATCH v6 00/21] ILP32 for ARM64
In-Reply-To: <mvmbn68drw9.fsf@hawking.suse.de>
References: <1452792198-10718-1-git-send-email-ynorov@caviumnetworks.com>
 <6653982.FK62mVSCZO@wuerfel> <mvmbn68drw9.fsf@hawking.suse.de>
Message-ID: <9954557.6jHvOcOYGT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 March 2016 11:52:54 Andreas Schwab wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > What exactly do you need to define F_GETLK64 for on LP64?
> 
> To override the generic definitions.


Ok, got it. I misread that part as adding definitions for LP64, but it
is correctly removing the definitions for ILP32.

	Arnd
