From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 26 Sep 2013 08:15:54 +0200
Subject: [PATCH 23/26] ARM: sunxi: remove custom .init_time hook
In-Reply-To: <20130925200731.GM2954@lukather>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-24-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130925200731.GM2954@lukather>
Message-ID: <5243D11A.5090808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2013 10:07 PM, Maxime Ripard wrote:
> On Wed, Sep 18, 2013 at 07:53:56PM +0200, Sebastian Hesselbarth wrote:
>> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
>> remove custom .init_time hooks.
>>
>> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> How do you want us to merge this? Every maintainer takes the patches he
> handles, or will Kevin and Olof merge the whole thing?

Maxime,

I am still waiting for some ACKs (nomadik, prima2, socfpga, nspire) and
possibly Mike's on the clock changes.

My current idea is to prepare a branch for Olof to pull in as whole.

Sebastian
