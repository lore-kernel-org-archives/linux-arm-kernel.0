From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 21 Jun 2018 09:51:12 -0400
Subject: Dynamic ftrace self test broken on ARM
In-Reply-To: <daf9cea94b0baf23563c575fbab1a4da@agner.ch>
References: <65fb14b356bc0a414f1fe5cf5c6eb395@agner.ch>
 <20180618175437.3e6c85a1@gandalf.local.home>
 <b9f269ed2143688c38cdcbba7367b101@agner.ch>
 <20180619091735.7aec75d0@gandalf.local.home>
 <5e26cebbb2ebeb87fdc808509881736b@agner.ch>
 <20180620101311.0bcd73d3@gandalf.local.home>
 <7904ed3fe9f59a54526d64f366915b43@agner.ch>
 <e4181ae694d44913a8eba4618477bd3b@agner.ch>
 <ac0178fb75658a8d7d7b1931691c7755@agner.ch>
 <20180620230734.GO17671@n2100.armlinux.org.uk>
 <20180620212906.24b7b66e@vmware.local.home>
 <daf9cea94b0baf23563c575fbab1a4da@agner.ch>
Message-ID: <20180621095112.63a40f1e@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Jun 2018 09:25:48 +0200
Stefan Agner <stefan@agner.ch> wrote:


> This aligns nicely with how this has been solved with commit
> 162396309745 ("ftrace, x86: make kernel text writable only for
> conversions") a while ago.
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> 
> Compiled and tested here, selftest as well as ftrace at runtime seems to
> work fine.
> Tested-by: Stefan Agner <stefan@agner.ch>
> 
> Thanks Steven! Can you send a patch or should I do it?

I'll resend a proper patch. Thanks for looking into it!

-- Steve
