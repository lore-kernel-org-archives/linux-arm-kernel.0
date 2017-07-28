From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 27 Jul 2017 17:29:07 -0700
Subject: [PATCH v3.1 0/3] soc: amlogic: Add Amlogic SoC Information driver
In-Reply-To: <e9558b4f-b155-9f25-fe39-b876973299b5@baylibre.com> (Neil
 Armstrong's message of "Thu, 13 Jul 2017 12:25:20 +0200")
References: <1498206498-19139-1-git-send-email-narmstrong@baylibre.com>
 <CAFBinCAK0iXJ5zLg64oABXs7rno48Dni6Zc2dQ3_aadJS7wiSQ@mail.gmail.com>
 <e9558b4f-b155-9f25-fe39-b876973299b5@baylibre.com>
Message-ID: <7h4ltxs8to.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 07/12/2017 09:03 PM, Martin Blumenstingl wrote:
>> Hi Kevin,
>> 
>> On Fri, Jun 23, 2017 at 10:28 AM, Neil Armstrong
>> <narmstrong@baylibre.com> wrote:
>>> Amlogic SoCs have a SoC information register for SoC type, package type and
>>> revision information.
>>> This patchset adds support for this register decoding and exposing with the
>>> SoC bus infrastructure, with dt-bindings and DT node.
>> I'm curious: are you going to take this through your tree or are we
>> waiting for someone's ACK here?
>
> I'm curious also, it should go through armsoc-drivers, no ?

I was being lazy and assuming that Arnd would have another look as he
reviewed an earlier version, but since there appear to be no further
reviews/comments, I'll take it through the amlogic tree in the
v4.14/drivers branch.

Kevin
