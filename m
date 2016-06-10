From: slash.tmp@free.fr (Mason)
Date: Fri, 10 Jun 2016 23:37:42 +0200
Subject: Linux panics when suspend cannot offline the secondary cores
In-Reply-To: <2026483.61HqCp9Eli@vostro.rjw.lan>
References: <575ADFAC.4090009@free.fr> <2026483.61HqCp9Eli@vostro.rjw.lan>
Message-ID: <575B3326.1050500@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2016 23:35, Rafael J. Wysocki wrote:
              ^^^^^

Your clock is 5 minutes ahead ;-)

> On Friday, June 10, 2016 05:41:32 PM Mason wrote:
>
>> I'm playing with S3 Suspend-to-RAM, and I noticed that Linux is really
>> unhappy when the suspend framework fails to offline secondary cores.
>>
>> Is this expected/by design, or could it fail more gracefully?
>> (It could also be something missing in my platform's code.)
> 
> This looks like a CPU offline bug to me which is more general than just
> system suspend.

You may be right, I will try just off-lining cpu1.
Suspend may be a red herring.

By the way, I know my implementation of tango_cpu_die
is incorrect, I was testing the failure mode.

Regards.
