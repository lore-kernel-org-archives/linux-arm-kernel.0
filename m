From: peter@hurleysoftware.com (Peter Hurley)
Date: Sun, 01 Feb 2015 12:07:43 -0500
Subject: [PATCH 2/3] tty/serial: of_serial: add support for PXA/MMP uarts
In-Reply-To: <54CBE868.3080100@hurleysoftware.com>
References: <1422334209-23125-1-git-send-email-robh@kernel.org>
 <1422334209-23125-2-git-send-email-robh@kernel.org>
 <54C78823.7050504@hurleysoftware.com>
 <CAL_Jsq+8jDN+fYyed5RYd2e1K+H_R1NkjT38WXSpKfxTLgsDbQ@mail.gmail.com>
 <54C7AA2D.7080202@hurleysoftware.com>
 <CAL_Jsq+wxY0=S1ff-Fk0xDBxHdhBvNopLpjfCETVoo_mou658w@mail.gmail.com>
 <54C91E67.2070501@hurleysoftware.com>
 <CAL_Jsq+6jg7C0z=0ZS=yp32_6yWzfx_zr5dtu-n3mv0JWiGq2g@mail.gmail.com>
 <54CBE868.3080100@hurleysoftware.com>
Message-ID: <54CE5D5F.8080009@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/30/2015 03:24 PM, Peter Hurley wrote:
> On 01/30/2015 02:51 PM, Rob Herring wrote:
>> On Wed, Jan 28, 2015 at 11:37 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> On 01/27/2015 11:44 AM, Rob Herring wrote:
>> So after all the discussion, you are okay with the original patch?
> 
> With a more specific commit log, yes. At a minimum, noting under what
> circumstances the 8250 driver replaces the pxa2xx-uart driver. (And maybe
> noting that this doesn't break hardware that needs those workarounds in
> pxa.c).

nvm; upstreamed.
