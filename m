From: broonie@kernel.org (Mark Brown)
Date: Sat, 5 Jul 2014 17:43:48 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140705111406.GA23692@arm.com>
References: <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com>
 <20140702163923.GJ410@sirena.org.uk>
 <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
 <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
 <20140703174318.GE28175@arm.com>
 <20140704132250.A2447C40ADD@trevor.secretlab.ca>
 <20140705111406.GA23692@arm.com>
Message-ID: <20140705164348.GM14896@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 05, 2014 at 12:14:07PM +0100, Catalin Marinas wrote:

> The timeline I propose would be:
> 
> 1. Architecture feature deprecation (still present, no way to disable)
>    - In Linux we need to find ways and push for alternatives to be
>      adopted by user space (like we did with kuser helpers)

Is it worth adding a non-default option to either disable and emulate or
just completely disable during this phase rather than at step 2 (perhaps
with a sysctl)?  That would help people who want to test that what they
are doing is going to work going forwards.  The work is going to have to
happen anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140705/ea9f54d8/attachment.sig>
