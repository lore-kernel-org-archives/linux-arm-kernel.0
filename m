From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 20 Nov 2018 11:11:46 +0000
Subject: [RFC 0/3] Unify CPU topology across ARM64 & RISC-V
In-Reply-To: <07d92dd4-f943-47ee-e168-46bfaf4ed755@codeaurora.org>
References: <1541728209-3224-1-git-send-email-atish.patra@wdc.com>
 <07d92dd4-f943-47ee-e168-46bfaf4ed755@codeaurora.org>
Message-ID: <20181120111146.GA6497@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 11:31:33AM -0700, Jeffrey Hugo wrote:

[...]

>
> I was interested in testing these on QDF2400, an ARM64 platform, since this
> series touches core ARM64 code and I'd hate to see a regression. However, I
> can't figure out what baseline to use to apply these. Different patches
> cause different conflicts of a variety of baselines I attempted.
>

Good to know that we can test DT configuration on QDF2400. I always assumed
it's ACPI only.

> What are these intended to apply to?
>

The series alone may not get the package/socket ids correct on QDF2400.
I have not yet added support for the same as I wanted to get the initial
feedback on DT bindings. The movement of DT binding and corresponding
code should not regress and you should be able to validate only that
part.

--
Regards,
Sudeep
