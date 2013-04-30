From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Mon, 29 Apr 2013 19:52:41 -0700
Subject: [GIT PULL] KVM/ARM Changes for 3.10
In-Reply-To: <20130430021136.GB14088@amt.cnet>
References: <CAEDV+gKXcCb11p5YCQRbQ1OwGefxYUr0sh8f4AOfxQSPPo2LMQ@mail.gmail.com>
 <20130430021136.GB14088@amt.cnet>
Message-ID: <CAEDV+gLbqUgzkRoToYKSBTXKzUkY40fO80rcviu-EHcbxYjL4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 29, 2013 at 7:11 PM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> On Sun, Apr 28, 2013 at 10:29:07PM -0700, Christoffer Dall wrote:
>> Hi Marcelo and Gleb,
>>
>> These are the changes for KVM/ARM for 3.10.
>>
>> The patches depend on the cleanup branch, which you've already merged.
>>
>> Main thing is the reworking of Hyp idmaps, which is now handled by KVM
>> instead of arm/mm and includes several nasty bug fixes from Marc in
>> the progress.
>>
>> Thanks!
>>
>> The following changes since commit 5a2892ce72e010e3cb96b438d7cdddce0c88e0e6:
>>
>>   KVM: nVMX: Skip PF interception check when queuing during nested run
>> (2013-04-28 13:34:39 +0300)
>>
>> are available in the git repository at:
>>
>>   git://github.com/columbia/linux-kvm-arm.git kvm-arm-for-3.10
>>
>> for you to fetch changes up to d4e071ce6acf8d5eddb7615a953193a8b0ad7c38:
>>
>>   ARM: KVM: iterate over all CPUs for CPU compatibility check
>> (2013-04-28 22:23:23 -0700)
>
> Christoffer,
>
> Please email the patches to kvm at vger.
>
>

each of them were already cc'ed on the kvm mailing list when they were
reviewed I believe, but would you like to have them re-sent as they
are not in this pull request even if it means re-sending them?

-Christoffer
