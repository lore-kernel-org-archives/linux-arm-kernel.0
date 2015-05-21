From: nm@ti.com (Nishanth Menon)
Date: Thu, 21 May 2015 01:04:07 -0500
Subject: [PATCH V5 3/3] OPP: Add binding for 'opp-suspend'
In-Reply-To: <20150521054935.GG22904@linux>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <618b02107af650bcb3246e165095bbca207d511a.1432091956.git.viresh.kumar@linaro.org>
 <555D6DD3.7000404@ti.com> <20150521054935.GG22904@linux>
Message-ID: <555D7557.6060501@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2015 12:49 AM, Viresh Kumar wrote:
> On 21-05-15, 00:32, Nishanth Menon wrote:
>> Why not just mark it as a property of an OPP rather than a phandle? just
>> thinking that this might setup a precedence for future needs like
>> "shutdown OPP" or "Reboot OPP" or something different that some other
>> SoC might have..
> 
> AFAIU, a property should be present in the OPP if and only if any OPP
> can set it. But in this case, only one OPP from the entire list can
> set it. So, its more a property of the list rather than every OPP
> within it. And then there wouldn't be any need to code that would
> check bugs in dtbs where multiple OPPs have it set.
> 
True.. fair enough.

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
