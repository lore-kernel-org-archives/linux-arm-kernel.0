From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 6 Jul 2011 20:44:12 +0800
Subject: [PATCH 3/3 v2] ARM: pxa168: Add board support for gplugD
In-Reply-To: <CACTFLANNMPS68OQ6tjOjZjw+aH2GHEV7uHjcjOj7RLNZFtMGZQ@mail.gmail.com>
References: <1304316000-869-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<453554c85ebd364f14cd10953730171d6814d009.1308721057.git.tanmay.upadhyay@einfochips.com>
	<CACTFLANNMPS68OQ6tjOjZjw+aH2GHEV7uHjcjOj7RLNZFtMGZQ@mail.gmail.com>
Message-ID: <CAMPhdO88KS0uzDvBgqL3B63cqmGTx83ELCA+fS-SaauMeb7gaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 6, 2011 at 8:20 PM, Daniel Mack <zonque@gmail.com> wrote:
> On Wed, Jun 22, 2011 at 7:55 AM, Tanmay Upadhyay
> <tanmay.upadhyay@einfochips.com> wrote:
>> Tested UART console, Ethernet & I2C interfaces
>>
>> v2 - move definitions from mfp-gplugd.h to mfp-pxa168.h
>>
>> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
>
> Thank you for this patch. Are you working on support for more
> components of this device, for example the display controller?

Daniel,

The basic support should be there - pxa168fb.c, yet the HDMI part is
missing.  Another trend is to use KMS maybe for such a complicated
controller capable of different outputs.

>
>
> Daniel
>
