From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 2 Nov 2017 11:06:42 -0500
Subject: [GIT PULL] SoCFPGA DTS updates for v4.15, part 2
In-Reply-To: <CAK8P3a02AjaD7P0=1stt05-8kNuzfoUM1kZFubYd6EwfE7NYGg@mail.gmail.com>
References: <1509374569-5811-1-git-send-email-dinguyen@kernel.org>
 <CAK8P3a02AjaD7P0=1stt05-8kNuzfoUM1kZFubYd6EwfE7NYGg@mail.gmail.com>
Message-ID: <dc25f1c2-6ee2-69b7-367b-99569b7513c2@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 11/02/2017 10:39 AM, Arnd Bergmann wrote:
> On Mon, Oct 30, 2017 at 3:42 PM, Dinh Nguyen <dinguyen@kernel.org> wrote:
>> Alan Tull (2):
>>       arm64: dts: stratix10: add gpio header
>>       arm64: dts: stratix10: enable gpio and leds
>>
>> Dinh Nguyen (1):
>>       arm64: dts: stratix10: fix interrupt number for gpio1
> 
> Pulled into next/dt. Should the last one here be marked "Cc:
> stable at vger.kernel.org"?

I don't think it's necessary. The stratix10 platform is relatively new
and should only be supported from v4.15 onward.

Thanks,
dinh
