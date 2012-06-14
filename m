From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 14 Jun 2012 16:06:26 -0500
Subject: [PATCH v5 10/14] ARM: OMAP2+: gpmc: waitpin helper
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9996FC@DBDE01.ent.ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <bba49a35f81f33fbdfeda78a71cbe4aa3417d6a2.1339419492.git.afzal@ti.com>
 <4FD6783D.9030208@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997F7C@DBDE01.ent.ti.com>
 <4FD78748.2080504@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998955@DBDE01.ent.ti.com>
 <4FD8B55E.6010701@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9996FC@DBDE01.ent.ti.com>
Message-ID: <4FDA5252.2050401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Afzal,

On 06/14/2012 03:48 AM, Mohammed, Afzal wrote:
> Hi Jon,
> 
> On Wed, Jun 13, 2012 at 21:14:30, Hunter, Jon wrote:
>> On 06/13/2012 02:37 AM, Mohammed, Afzal wrote:
> 
>>> In that case we would be directly depending on user flag whose value may
>>> or may not change and I don't think it is good to directly depend on it
>>> for waitpin # calculation.
>>
>> You are already dependent on it. In other words, you are going to set
> 
> What I meant is we are not dependent on absolute value of flag to
> find waitpin, and I disagree in depending on its absolute value,
> which can change, while flag would be the same.

As long as we can avoid having multiple #defines for the same thing, I
don't mind how it is done.

Jon
