From: slash.tmp@free.fr (Mason)
Date: Sat, 4 Mar 2017 18:29:46 +0100
Subject: Panic in quirk_usb_early_handoff
In-Reply-To: <46A35088-88E2-425B-963E-0DC2DCC54890@linaro.org>
References: <4b2a7606-de27-c8ad-1530-958dd5d12233@free.fr>
 <45e38a07-e8da-80e4-36bb-31e471f02004@free.fr>
 <3c5bd8f5-468f-d25e-08a9-8944ee419096@free.fr>
 <38b8c9be-724b-0cfc-a941-76f2c62e1c58@arm.com>
 <4f0a6c67-a50b-ac24-8ffa-0a68802e84b8@free.fr>
 <CAKv+Gu_M6aMMfeCy7ZUM46Ptei1suvX+F_KtWG2_QFp_6jbCWw@mail.gmail.com>
 <4a07dbec-dcde-9ec0-514f-3b896e2b0b19@free.fr>
 <46A35088-88E2-425B-963E-0DC2DCC54890@linaro.org>
Message-ID: <ed4e332d-28d6-e143-b2b3-f1e2829e89a7@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2017 18:16, Ard Biesheuvel wrote:

> After pc, the link register is the most likely to legally point into
> the kernel .text section so it makes sense imo to decode the address
> into a function name plus offset.

Does gcc ever use the link register as a general purpose register?
(In which case, it is very likely to contain "garbage" as far as
function addresses are concerned.)

> Educating people about the architecture's calling convention and
> associated caveats is not the job of the panic handler.

That's a weird statement.

Regards.
