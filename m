From: javier@javigon.com (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Mon, 6 Jun 2016 20:51:23 +0200
Subject: [PATCH v10 0/4] generic TEE subsystem
In-Reply-To: <1464784888-19854-1-git-send-email-jens.wiklander@linaro.org>
References: <1464784888-19854-1-git-send-email-jens.wiklander@linaro.org>
Message-ID: <A8774850-9E8D-442D-AF8C-80948822803C@javigon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On 01 Jun 2016, at 14:41, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> 
> [TL;DR; This patch set needs more review, if you're using OP-TEE please
> help reviewing.]
> 
> This patch set introduces a generic TEE subsystem. The TEE subsystem will
> contain drivers for various TEE implementations. A TEE (Trusted Execution
> Environment) is a trusted OS running in some secure environment, for
> example, TrustZone on ARM CPUs, or a separate secure co-processor etc.

Have you considered moving the code to a security subsystem? Back in the
days I talked to some of the TPM maintainers and they were not closed to
the idea of having support for hardware security extensions in a single
place. I think TPM is still considered as a char device...

We would all benefit if it were possible to have an overview of all
available all the security extensions, if nothing else at least for the
documentation.

Javier
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 842 bytes
Desc: Message signed with OpenPGP using GPGMail
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160606/0be9589b/attachment.sig>
