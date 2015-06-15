From: lina.iyer@linaro.org (Lina Iyer)
Date: Mon, 15 Jun 2015 13:14:34 -0600
Subject: [PATCH RFC 3/3] PM / Domains: Introduce generic PM domain for
 cpu domain
In-Reply-To: <7hioao6cd2.fsf@deeprootsystems.com>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-4-git-send-email-lina.iyer@linaro.org>
 <7hmw07meh6.fsf@deeprootsystems.com>
 <20150611145649.GC1103@linaro.org>
 <7hioao6cd2.fsf@deeprootsystems.com>
Message-ID: <20150615191434.GA14311@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15 2015 at 12:43 -0600, Kevin Hilman wrote:
>Lina Iyer <lina.iyer@linaro.org> writes:
>
>> On Wed, Jun 10 2015 at 15:38 -0600, Kevin Hilman wrote:
>>>Lina Iyer <lina.iyer@linaro.org> writes:


>I'm pretty sure the generic code will already add devices to genpds if
>the genpd is using the of_genpd_* stuff.  That is why I'm wondering why
>the extra stuff for CPUs is needed.
>
I dont see that automatically happening. When I attach a device, it
finds the corresponding genpd provider and attaches the device.  But I
dont see in any code that creates genpd and find the related device
nodes and adds them to the genpd.

May be I am missing something.

-- Lina
