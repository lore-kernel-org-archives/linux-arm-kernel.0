From: peter.maydell@linaro.org (Peter Maydell)
Date: Mon, 28 Nov 2016 11:14:48 +0000
Subject: [Qemu-devel] [kvm-unit-tests PATCH v7 00/11] QEMU MTTCG Test cases
In-Reply-To: <878ts3uac6.fsf@linaro.org>
References: <20161124161033.11456-1-alex.bennee@linaro.org>
 <20161128103744.s3wq53xzsxvu5uus@kamzik.brq.redhat.com>
 <878ts3uac6.fsf@linaro.org>
Message-ID: <CAFEAcA9JUOHnJL59EuhQ_dEWjt+YjEcu8LGiJ3CSk_7R4J5Efg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 November 2016 at 11:12, Alex Benn?e <alex.bennee@linaro.org> wrote:
>
> Andrew Jones <drjones@redhat.com> writes:
>> I've skimmed over everything looking at it from a framwork/sytle
>> perspective. I didn't dig in trying to understand the tests though.
>> One general comment, I see many tests introduce MAX_CPUS 8. Why do
>> that? Why not allow all cpus by using NR_CPUS for the array sizes?
>
> Yeah - I can fix those. I wonder what the maximum is with GIC V3?

So large that you don't want to hardcode it as an array size...

thanks
-- PMM
