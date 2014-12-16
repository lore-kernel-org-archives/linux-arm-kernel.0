From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 16 Dec 2014 11:16:36 +0100
Subject: [GIT PULL] at91: fixes for 3.19 #1
In-Reply-To: <7hmw6oh7xh.fsf@deeprootsystems.com>
References: <1418377615-15122-1-git-send-email-nicolas.ferre@atmel.com>
 <7hmw6oh7xh.fsf@deeprootsystems.com>
Message-ID: <54900684.6040802@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 15/12/2014 23:20, Kevin Hilman a ?crit :
> Nicolas Ferre <nicolas.ferre@atmel.com> writes:
> 
>> Arnd, Olof, Kevin,
>>
>> I'm sending today a "fixes" branch which somehow continues the cleanup with
>> only code removal. I was waiting for the arm-soc *and* pinctrl material to
>> reach Linus T.'s tree before sending this pull-request. In fact this sequence
>> was needed for the gpio header removal. The little patch about #include
>> deletion just follows an earlier merge conflict in arm-soc tree: I was also
>> waiting for this moment before sending the definitive fix, just to be sure.
>>
>> Otherwise, all is pretty straightforward.
>>
>> Oh, one more thing: it is based on the current Linus' git tree, I can obviously
>> rebase everything on top of 3.19-rc1 once it is released if you prefer.
> 
> Yes, waiting a bit and basing on v3.19-rc1 is preferred since none of
> this seems like urgent fixes needed for stuff introduced during the
> merge window.

Absolutely, I'll do this.

Bye,
-- 
Nicolas Ferre
