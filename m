From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 04 May 2015 16:43:51 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <7C69BC10-51BC-4276-95A6-9BE6B70A6D75@theobroma-systems.com>
References: <025BB233-8D14-457A-B3B2-C6BD6C3B32EF@theobroma-systems.com>
 <3908616.DHRS6D2Ytk@wuerfel>
 <7C69BC10-51BC-4276-95A6-9BE6B70A6D75@theobroma-systems.com>
Message-ID: <2976457.fcjF56CJBy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 May 2015 12:32:30 Dr. Philipp Tomsich wrote:
> Arnd,
> 
> Where can I pull this prototype implementation from?
> As we are working on getting a final ILP32 change-set ready, I?d like to make
> sure that we base this on the latest consensus for new ILP32 ABIs on 64bit
> machines.
> 

I currently have an early prototype that I have done on top of another
working branch. You can find it at

git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038-syscalls

to see the current state, but as this has so far not been posted for review
to a wider group of people, I expect that a lot of details will change, possibly
even the overall approach I've taken. See also my introduction at
https://lists.linaro.org/pipermail/y2038/2015-May/000178.html

	Arnd
