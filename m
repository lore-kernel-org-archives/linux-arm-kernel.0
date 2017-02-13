From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 13 Feb 2017 13:04:59 -0800
Subject: [PATCH 07/10] ARM: davinci: fix a whitespace error
In-Reply-To: <m2o9y6djl1.fsf@baylibre.com> (Kevin Hilman's message of "Mon, 13
 Feb 2017 10:36:10 -0800")
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
 <1486485683-11427-8-git-send-email-bgolaszewski@baylibre.com>
 <m2o9y6djl1.fsf@baylibre.com>
Message-ID: <m260kder9g.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@baylibre.com> writes:

> Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:
>
>> There's a stray tab in da850_vpif_legacy_init(). Remove it.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Folding into the original,

Looks like the version in Sekhar's v4.11/soc branch already has this
fixed.

Kevin
