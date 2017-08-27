From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 27 Aug 2017 12:28:38 +0200
Subject: [PATCH v2 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <20170827082714.nya7m3movufujtjk@piout.net>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de> <20170827020501.GB13622@lunn.ch>
 <a2a21bc4-b7a9-cadf-920c-f078c673dbb9@suse.de>
 <20170827082714.nya7m3movufujtjk@piout.net>
Message-ID: <1e054135-b825-5d3e-e508-201589b0c451@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.08.2017 um 10:27 schrieb Alexandre Belloni:
> On 27/08/2017 at 04:30:08 +0200, Andreas F?rber wrote:
>> Am 27.08.2017 um 04:05 schrieb Andrew Lunn:
>> By that same argument we could ask why so many drivers (and mine, too)
>> are calling rtc_valid_tm() when __rtc_read_time() calls it again...
> 
> Most of them probably predates the introduction of the check in
> __rtc_read_time().

Replacing with 0 here then.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
