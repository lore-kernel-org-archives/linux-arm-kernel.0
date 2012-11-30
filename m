From: wd@denx.de (Wolfgang Denk)
Date: Fri, 30 Nov 2012 09:32:52 +0100
Subject: nfs root not responding?
In-Reply-To: <slrnkbgkqq.2kq.narkewoody@zuhnb712.local.com>
References: <slrnkbgkqq.2kq.narkewoody@zuhnb712.local.com>
Message-ID: <20121130083252.B4301200171@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Woody Wu,

In message <slrnkbgkqq.2kq.narkewoody@zuhnb712.local.com> you wrote:
> 
> I just enabled the network in the kernel and trying to load a rootfs
> from remote nfs server.  The kernel did the DHCP succeed and got the
> ip and other network parameters.  But it then keep always complaining
> that "nfs server not responding" and the login prompt does not show up.

Try adding "proto=tcp" as mount option and test if this changes
anything.

You may also want to have a look at this FAQ:
http://www.denx.de/wiki/view/DULG/EthernetIsUnreliable


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
"Beware of bugs in the above code; I have only proved it correct, not
tried it."                                             - Donald Knuth
