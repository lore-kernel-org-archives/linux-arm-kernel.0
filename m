From: zonque@gmail.com (Daniel Mack)
Date: Wed, 16 Nov 2011 15:19:01 +0100
Subject: [PATCH] ARM: pxa: add support for Raumfeld DDX
In-Reply-To: <20111116141130.GF29986@opensource.wolfsonmicro.com>
References: <1320661562-422-1-git-send-email-zonque@gmail.com>
 <20111115141348.GG3077@opensource.wolfsonmicro.com>
 <4EC3B30F.60403@gmail.com>
 <20111116131910.GE29986@opensource.wolfsonmicro.com>
 <4EC3C376.3040007@gmail.com>
 <20111116141130.GF29986@opensource.wolfsonmicro.com>
Message-ID: <4EC3C655.6000100@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2011 03:11 PM, Mark Brown wrote:
> On Wed, Nov 16, 2011 at 03:06:46PM +0100, Daniel Mack wrote:
>> Sorry, I still don't get it. All implementations I can find call
>> snd_soc_dai_set_fmt() for the cpu and codec dais from the
>> .ops->hw_params function they reference from their snd_soc_dai_links.
>> Just like this new code does as well. What am I missing?
> 
> Are you *sure* you're looking at current code?  The dai_fmt field isn't
> that obscurely named...

Grrr. Sorry for that. We're based on 3.1 here, I should have noticed.
I'll rebase, do all necessary cleanups and resubmit.


Daniel
