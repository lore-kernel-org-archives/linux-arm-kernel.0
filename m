From: robh@kernel.org (Rob Herring)
Date: Mon, 23 Jan 2017 08:02:44 -0600
Subject: [PATCH 6/6] dt-bindings: mt8173-mtu3: add reference clock
In-Reply-To: <1485049780.10292.78.camel@mhfsdcap03>
References: <1484719707-12107-1-git-send-email-chunfeng.yun@mediatek.com>
 <1484719707-12107-6-git-send-email-chunfeng.yun@mediatek.com>
 <20170121201155.cqcihopdc3kjyfi6@rob-hp-laptop>
 <1485049780.10292.78.camel@mhfsdcap03>
Message-ID: <CAL_JsqJg7=ykNkAbMeLqFT6HK-pK+FQAK7ZS_UMMy8ftrGM-KA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 21, 2017 at 7:49 PM, Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> Hi,
>
> On Sat, 2017-01-21 at 14:11 -0600, Rob Herring wrote:
>> On Wed, Jan 18, 2017 at 02:08:27PM +0800, Chunfeng Yun wrote:
>> > add a reference clock for compatibility
>>
>> Why? This block suddenly has 2 clocks instead of 1?
> In fact, there is a reference clock which comes from 26M oscillator
> directly. I ignore it because it is a fixed-clock in DTS, and always
> turned on for mt8173. But later, I find that I made a mistake before
> when I bring up it on a new platform whose reference clock comes from
> PLL, and need control it. So here add it, no matter it is a fixed-clock
> or not.

Add this explanation to the changelog.

Rob
