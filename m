From: rob.lee@linaro.org (Rob Lee)
Date: Mon, 12 Mar 2012 12:03:48 -0500
Subject: linux-next: manual merge of the cpuidle-cons tree with the
 arm-soc tree
In-Reply-To: <4F5E1ECC.1040605@atmel.com>
References: <20120309183732.512d3676599da324f4747219@canb.auug.org.au>
 <4F5E1ECC.1040605@atmel.com>
Message-ID: <CAMXH7KH_vgri3EPRvkXR+LddRUc=0ve=4u7yr51utBfgV5bF3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Stephen, Nicolas, Daniel,

On Mon, Mar 12, 2012 at 11:05 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 03/09/2012 08:37 AM, Stephen Rothwell :
>> Hi Rob,
>>
>> Today's linux-next merge of the cpuidle-cons tree got a conflict
>> in arch/arm/mach-at91/cpuidle.c between commit 00482a4078f4 ("ARM:
>> at91: implement the standby function for pm/cpuidle") from the
>> arm-soc tree and commit 7a1f6e72dce1 ("ARM: at91: Consolidate time
>> keeping and irq enable") from the cpuidle-cons tree.
>>
>> I fixed it up (I think - see below) and can carry the fix as
>> necessary.
>
> Yes: resolution correct. Please carry it.
>

Who should carry this fixup and related necessary at91 changes?  Me?
FYI, my at91 changes are dependent on my core cpuidle change, but my
core cpuidle changes do not require any at91 changes as the at91 and
other platform changes were only made to consolidate duplicate code.

Best Regards,
Rob

> Thanks to Rob and Daniel for their answers.
>

Thank you as well Nicolas.

> Best regards,
> - --
> Nicolas Ferre
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iQEcBAEBAgAGBQJPXh7HAAoJEAf03oE53VmQSQwH/15D3okPxJSEiH0k8IFt6Df0
> RDY/CdaGYDllGMq7Yc1LiQAPrlHkv+gFNAJkhH8aJvC603pYBFGIa5IPLeZEE+XD
> MkXiO7pQAOdGtojqSrZI8Sp0kxtfdR6QlNu5o518yvlKIkxbWJoXdVty9+MuciOv
> GOR+164hJtlr4fLLg7bTzsdnxquDVBBbks9qLhSYEQBEuNkgXKgNfdMouwVI/Zuj
> sX9DSKnVVm5LS/rrq888JRPPtBf8/HkmOeFRWKktq7Q8WldQbBI79vj01osH++jf
> rwDiM/CSC0nhXY0IWEof+Hz1mSinM07XGZglDYwqI1ca7HId2C/txaFI3NtcC7A=
> =rZpG
> -----END PGP SIGNATURE-----
