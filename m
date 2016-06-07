From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 7 Jun 2016 10:02:37 +0200
Subject: [PATCH v4 00/12] KVM: arm64: GICv3 ITS emulation
In-Reply-To: <DB5PR04MB09977DF578DFB03A582745869A5C0@DB5PR04MB0997.eurprd04.prod.outlook.com>
References: <1458958450-19662-1-git-send-email-andre.przywara@arm.com>
 <DB5PR04MB099754E61027226E5210C2399A590@DB5PR04MB0997.eurprd04.prod.outlook.com>
 <32b86adb-cdba-89bb-3f19-e7677f39fa1f@arm.com>
 <DB5PR04MB09977DF578DFB03A582745869A5C0@DB5PR04MB0997.eurprd04.prod.outlook.com>
Message-ID: <CAMJs5B8h6wj16AMXVmuUa00TRzBJRq3_xMJfMEH67F1GMFJ2AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bharat,



On Mon, Jun 6, 2016 at 7:29 AM, Bharat Bhushan <bharat.bhushan@nxp.com> wrote:
> Hi Andre,
>
> On clarification, are V5 version of patches are based on new-GIC emulation patches? How are you testing these patches, kvm-tool?
>
> Hi Christoffer/Peter,
>
> Is someone working on QEMU side patches? We need this feature a bit urgently so if no one is working then we can start working on this.
>
Eric Auger (now with Red Hat) was planning to pick up Pavel's series
and do a respin:

https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg05197.html

If you are ready to commit resources to this *immediately* and if Eric
agrees then it would be good for you to pick up this series, but
should you choose to do so please make sure you can actually commit
resources to the work and to keep up with revisions this time around.

Thanks,
-Christoffer
