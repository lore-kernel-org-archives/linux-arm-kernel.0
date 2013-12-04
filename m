From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 5 Dec 2013 04:13:35 +0530
Subject: [GIT PULL] DaVinci fixes for v3.13-rc3
In-Reply-To: <CAOesGMjRHM2Ycc9_tPJwaAwL_YgJPKqa3o5vaBFreV1pA6_7Jw@mail.gmail.com>
References: <529FAC81.6090102@ti.com>
 <CAOesGMjRHM2Ycc9_tPJwaAwL_YgJPKqa3o5vaBFreV1pA6_7Jw@mail.gmail.com>
Message-ID: <529FB017.4050102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Peter

Hi Olof,

On 12/5/2013 4:03 AM, Olof Johansson wrote:
> Hi,
> 
> Pulled.
> 
> A suggestion for the future, please try to use a patch description
> that doesn't require you to motivate why this is needed now. I.e. the
> patch description should contain:
> 
> What is broken
> How/when it broke (SHA or general timeframe)
> How it's fixed
> 
> In this case, it wasn't obvious what the actual breakage was (i.e.
> audio not working), nor when it was introduced.
> 
> Of course, if something is trivial you don't need to fill it in, nor
> should it be a form-based description. But those three answers should
> generally be possible to find in the patch description for a bugfix.

Yes, understood. I generally do push back on this and this time I (quite
unnecessarily) tried supplementing the information missing in
description through the tag signing message. Should have made sure the
commit description has the required information instead.

Thanks,
Sekhar
