From: mylene.josserand@free-electrons.com (Mylene Josserand)
Date: Wed, 1 Feb 2017 16:08:50 +0100
Subject: [PATCH v3 1/8] ASoC: sun4i-i2s: Update binding documentation to
 include A31
In-Reply-To: <20170201115958.7a2odxxyhzm3ofew@sirena.org.uk>
References: <20170131100552.27949-1-mylene.josserand@free-electrons.com>
 <20170131100552.27949-2-mylene.josserand@free-electrons.com>
 <20170131211702.taxbrgxwo7b4daej@sirena.org.uk>
 <feb16b69-388f-10e5-7be5-c750095ee52b@free-electrons.com>
 <20170201115958.7a2odxxyhzm3ofew@sirena.org.uk>
Message-ID: <b0611ab1-5b69-23da-6835-278d0fd1b6ba@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/02/2017 12:59, Mark Brown wrote:
> On Wed, Feb 01, 2017 at 08:44:56AM +0100, Mylene Josserand wrote:
>> On 31/01/2017 22:17, Mark Brown wrote:
>>> On Tue, Jan 31, 2017 at 11:05:45AM +0100, Myl?ne Josserand wrote:
>>>> Add a new compatible for sun4i-i2s driver to handle some
>>>> SoCs that have a reset line that must be asserted/deasserted.
>
>>> This doesn't apply against current code, please check and resend.
>
>> I based my series on linux-next 20170131. Which one I should use?
>
> You should be submitting against my git tree (which should be what's in
> -next...).
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
>

Okay, thank you! I will update my series according to your branch.

Best regards,

-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
