From: dborkman@redhat.com (Daniel Borkmann)
Date: Fri, 12 Sep 2014 19:39:21 +0200
Subject: [PATCH arm64-next] net: bpf: arm64: address randomize and write
 protect JIT code
In-Reply-To: <20140912172151.GI5532@arm.com>
References: <1410505897-20122-1-git-send-email-dborkman@redhat.com>
 <20140912160345.GF5532@arm.com> <54131D87.9060008@redhat.com>
 <20140912164656.GH5532@arm.com> <54132A76.4070501@redhat.com>
 <20140912172151.GI5532@arm.com>
Message-ID: <54132FC9.5040201@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2014 07:21 PM, Catalin Marinas wrote:
...
> We don't have a brk instruction for arm32 but we have guaranteed
> undefined space. Have a look at the kgdb support for example (or grep
> for register_undef_hook under arch/arm) to get an idea.

Will do, thanks!

>> Last but not least ;), if I would resend it today, would you queue
>> it for later on, or do you want to handle it differently?
>
> You can send it now, it will be pushed upstream at the right time.

Just did, thanks a lot for your help!
