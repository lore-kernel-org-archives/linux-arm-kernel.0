From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 12:52:16 +0100
Subject: [PATCH v2 02/16] ASoC: samsung: i2s: samsung_i2s_get_driver_data()
 cleanup
In-Reply-To: <20150106181402.GP2634@sirena.org.uk>
References: <1418997336-17777-1-git-send-email-s.nawrocki@samsung.com>
 <1418997336-17777-3-git-send-email-s.nawrocki@samsung.com>
 <20150106181402.GP2634@sirena.org.uk>
Message-ID: <54B65870.20509@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/15 19:14, Mark Brown wrote:
> On Fri, Dec 19, 2014 at 02:55:22PM +0100, Sylwester Nawrocki wrote:
>> > Tidy up the samsung_i2s_get_driver_data() function by using
>> > IS_ENABLE() instead of #ifdef and add missing braces for
>> > the 'else' part. Also ensure we are not dereferencing NULL
>> > 'match' pointer.
>
> This doesn't apply against current code, can you please check and
> resend?

OK, I will resend it rebased onto your 3.19-rc1 topic/samsung branch.
