From: d.lavnikevich@sam-solutions.com (Dmitry Lavnikevich)
Date: Fri, 3 Oct 2014 18:22:38 +0300
Subject: [PATCH v4 4/4] ASoC: tlv320aic3x: fix PLL D configuration
In-Reply-To: <20141003150807.GD24441@sirena.org.uk>
References: <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1412342336-25700-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1412342336-25700-5-git-send-email-d.lavnikevich@sam-solutions.com>
 <20141003150807.GD24441@sirena.org.uk>
Message-ID: <542EBF3E.8020106@sam-solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/10/14 18:08, Mark Brown wrote:
> On Fri, Oct 03, 2014 at 04:18:56PM +0300, Dmitry Lavnikevich wrote:
>> Current caching implementation during regcache_sync() call bypasses
>> all register writes of values that are already known as default
>> (regmap reg_defaults). Same time in TLV320AIC3x codecs register 5
>
> Applied, thanks.  This should really have been sent separately to the
> other patches - it's not in any way specific to the board and there's no
> dependency in either direction.

Thanks. You are right, I didn't thought about it. Will remember for later :)
