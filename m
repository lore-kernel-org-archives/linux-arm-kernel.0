From: heutling@who-ing.de (Sebastian Heutling)
Date: Mon, 16 Nov 2009 11:56:19 +0100
Subject: kernel panic - Attempted to kill init
In-Reply-To: <564715.9008.qm@web7604.mail.in.yahoo.com>
References: <564715.9008.qm@web7604.mail.in.yahoo.com>
Message-ID: <4B012FD3.7000907@who-ing.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2009 08:29 AM, abhijeet tripathi wrote:
> Hello,
>
> I am trying to do a nfs booting of arm-pb1176 but I am getting kernel panic "Kernel panic - not syncing: Attempted to kill init!".
> I checked my filesystem and it has "/sbin/init". Please let me know if I am missing anything. Below is the console logs:

Might be that some shared libraries which "/sbin/init" depends on are 
missing.

Basti
