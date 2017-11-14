From: khalid.aziz@oracle.com (Khalid Aziz)
Date: Tue, 14 Nov 2017 07:52:25 -0700
Subject: linux-next: Tree for Nov 7
In-Reply-To: <20171114090444.lhrkuywuls26g6lu@dhcp22.suse.cz>
References: <20171107162217.382cd754@canb.auug.org.au>
 <CACPK8Xfd4nqkf=Lk3n6+TNHAAi327r0dkUfGypZ3TpR0LqfS4Q@mail.gmail.com>
 <20171108142050.7w3yliulxjeco3b7@dhcp22.suse.cz>
 <20171110123054.5pnefm3mczsfv7bz@dhcp22.suse.cz>
 <CACPK8Xe5uUKEytkRiszdX511b_cYTD-z3X=ZsMcNJ-NOYnXfuQ@mail.gmail.com>
 <20171113092006.cjw2njjukt6limvb@dhcp22.suse.cz>
 <20171113094203.aofz2e7kueitk55y@dhcp22.suse.cz>
 <87lgjawgx1.fsf@concordia.ellerman.id.au>
 <20171113120057.555mvrs4fjq5tyng@dhcp22.suse.cz>
 <87h8txw87w.fsf@concordia.ellerman.id.au>
 <20171114090444.lhrkuywuls26g6lu@dhcp22.suse.cz>
Message-ID: <1510671145.4344.1.camel@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-11-14 at 10:04 +0100, Michal Hocko wrote:
> If there is a general consensus that this is the preferred way to go,
> I
> will post the patch as an RFC to linux-api
> 
> [1] http://lkml.kernel.org/r/20171113160637.jhekbdyfpccme3be at dhcp22.s
> use.cz

I prefer the new flag. It is cleaner and avoids unintended breakage for
existing flag.

--
Khalid
