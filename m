From: panand@redhat.com (Pratyush Anand)
Date: Wed, 14 Dec 2016 19:43:50 +0530
Subject: [PATCH 1/2] arm64: Add enable/disable d-cache support for
 purgatory
In-Reply-To: <20161214134457.GJ17982@leverpostej>
References: <cover.1479788404.git.panand@redhat.com>
 <7a4866b928c0905ec1074dce1bfc7984c968a58a.1479788404.git.panand@redhat.com>
 <5838834D.90205@arm.com> <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
 <9a79b666-7990-2a23-2d74-52b3317ce272@redhat.com> <58512A01.70101@arm.com>
 <20161214113701.GE17982@leverpostej>
 <3a6ac655-bfa6-0d90-6351-731ce36e99eb@redhat.com>
 <20161214134457.GJ17982@leverpostej>
Message-ID: <8a22f7bb-d0c4-8bda-4c2a-7a5c0b441a9b@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 14 December 2016 07:14 PM, Mark Rutland wrote:
>> Even for the non-kdump ie `kexec -l` case we do not have a
>> > functionality to bypass sha verification in kexec-tools. --lite
>> > option with the kexec-tools was discouraged and not accepted.
> Ok. Do you have a pointer to the thread regarding that, for context?
>

https://lists.ozlabs.org/pipermail/petitboot/2015-October/000141.html
https://lists.ozlabs.org/pipermail/petitboot/2015-October/000136.html

~Pratyush
