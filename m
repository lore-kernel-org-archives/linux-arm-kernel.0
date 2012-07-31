From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 31 Jul 2012 15:29:48 +0100
Subject: [PATCH 5/6] ARM: ux500: Enable HIGHMEM on all mop500 platforms
In-Reply-To: <20120731135614.GR6802@n2100.arm.linux.org.uk>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <1343741493-17671-10-git-send-email-lee.jones@linaro.org>
 <20120731135614.GR6802@n2100.arm.linux.org.uk>
Message-ID: <5017EBDC.6010005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/12 14:56, Russell King - ARM Linux wrote:
> On Tue, Jul 31, 2012 at 02:31:30PM +0100, Lee Jones wrote:
>> The current kernel commandline for ux500 based devices includes
>> hard-coded allocations for things like mali and hwmem, which
>> actually run over lowmem. Here we enable highmem in order to
>> avoid memory corruption errors.
>
> Err what?  highmem should make no difference if things are being done
> correctly.
>
> In other words, your patch description is too vague to understand what
> the problem is and why you have to force highmem on - and nothing should
> _require_ highmem.

I think I must have misunderstood some advice which was recently given 
to me. I'll drop the patch.

Thanks for reviewing.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
