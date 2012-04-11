From: rnibali@gmail.com (Roberto Nibali)
Date: Wed, 11 Apr 2012 09:01:57 +0200
Subject: [PATCH 27/40] ARM i.MX25: implement clocks using common clock
 framework
In-Reply-To: <CAOMZO5CEGL6UqM-NQJ8QiYomm5s8MnbLZj+M3qVmxgNLsDn4mw@mail.gmail.com>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-28-git-send-email-s.hauer@pengutronix.de>
 <CAONxwYNuCND1yrc8VwqBpoDsp3CBKGqTRkPD73WXO4Tu4vu4Gg@mail.gmail.com>
 <CAOMZO5CEGL6UqM-NQJ8QiYomm5s8MnbLZj+M3qVmxgNLsDn4mw@mail.gmail.com>
Message-ID: <CAONxwYN4a_fmzUaPNdS1Aygze=dGZ2iSFrDO9i6jcBZoqJ-8Uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Tue, Apr 10, 2012 at 22:45, Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Apr 10, 2012 at 5:10 PM, Roberto Nibali <rnibali@gmail.com> wrote:
>
>> Wouldn't it be better to adjust this to mx25-adc.0, since it already
>> has a user: the new i.MX25 ADC TS driver by your colleague Juergen
>> Beiser, no?
>
> Is this mx25 adc driver available somewhere?

Yes, but I couldn't find it anymore in the archives. You have to ask
Juergen Beisert directly. I could make a diff of my current git tree
with regard to the changes, however I have modified some bits an
pieces of his original work.

I could have sworn that he posted his driver framework somewhere ...
