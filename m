From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 13 Apr 2017 16:53:26 +0100
Subject: kvm/arm64: use-after-free in
 kvm_unmap_hva_handler/unmap_stage2_pmds
In-Reply-To: <20170413155045.GA8387@e107814-lin.cambridge.arm.com>
References: <CAAeHK+yjKm3mO2h9M30t-V_PnMhXEM887_zESCSg6gkbzivPsQ@mail.gmail.com>
 <20f6c994-d83e-7a6f-9f13-f10287211a6c@arm.com>
 <9f473bb9-d0eb-6803-1263-75ffef0301fe@redhat.com>
 <CAAeHK+x8udHKq9xa1zkTO6ax5E8Dk32HYWfaT05FMchL2cr48g@mail.gmail.com>
 <1050c9d8-5813-5df9-29e5-3ab6e61b5de6@arm.com>
 <88715300-ef58-e7bd-81f5-95e0b9c9c533@arm.com>
 <20170413155045.GA8387@e107814-lin.cambridge.arm.com>
Message-ID: <06ab8c28-031b-772f-6371-e3453b4bdbbe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/04/17 16:50, Suzuki K. Poulose wrote:
> On Thu, Apr 13, 2017 at 10:17:54AM +0100, Suzuki K Poulose wrote:
>> On 12/04/17 19:43, Marc Zyngier wrote:
>>> On 12/04/17 17:19, Andrey Konovalov wrote:

Please ignore the footer below, that was mistake from my side.

> --
> 2.7.4
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
>
