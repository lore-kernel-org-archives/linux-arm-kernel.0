From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sat, 08 Sep 2012 11:48:19 -0600
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <CAEi1pCTvXTbbNX8iDDKB_YtRTVeiSqf9y_cO2AjqtDCdBbK7qA@mail.gmail.com>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <CAG-w=x77y6ykh3FcyTtVAN85eOk1RP2CZ=ZG-_1091i5jYDF2A@mail.gmail.com>
 <50491F65.2020302@simon.arlott.org.uk>
 <CAEi1pCTvXTbbNX8iDDKB_YtRTVeiSqf9y_cO2AjqtDCdBbK7qA@mail.gmail.com>
Message-ID: <504B84E3.1030709@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2012 11:12 AM, popcornmix wrote:
> On Thu, Sep 6, 2012 at 11:10 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
>> I've been waiting over 3 months now for device tree support to be added
>> to the GPU-based bootloader and it still hasn't appeared.
> 
> Sorry Simon, I thought the device tree support was complete, apart
> from requiring the command line in the device tree file to be padded
> with spaces.
> I didn't realise it was holding anything up. I can look into this -
> was there anything else missing?

(hijacking the thread a little; sorry)

Popcornmix, I notice that a number of commits in Simon's repo are
Signed-off-by yourself. However, those S-o-b tags use the alias
"popcornmix" rather than your real name, and hence aren't considered
valid by upstream. It'd be great if you could give your permission to
Simon to rebase his branch and update all those tags with your real
name, or give others permission to rewrite your existing S-o-b tags with
your real name when taking those patches and sending them upstream.

Thanks.
