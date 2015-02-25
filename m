From: robertcnelson@gmail.com (Robert Nelson)
Date: Wed, 25 Feb 2015 13:09:11 -0600
Subject: [PATCH v2] ARM: dts: am335x-bone-common: enable aes and sham
In-Reply-To: <1424890361-31848-1-git-send-email-mporter@konsulko.com>
References: <1424890361-31848-1-git-send-email-mporter@konsulko.com>
Message-ID: <CAOCHtYisxjpQM4zvotNxhj3KaYrqb3cgCbTXPXphB1ZV2jCZ8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 12:52 PM, Matt Porter <mporter@konsulko.com> wrote:
> Beaglebone Black doesn't have AES and SHAM enabled like the
> original Beaglebone White dts. This breaks applications that
> leverage the crypto blocks so fix this by enabling these nodes
> in the am335x-bone-common.dtsi. With this change, enabling the
> nodes in am335x-bone.dts is no longer required so remove them.
>
> Signed-off-by: Matt Porter <mporter@konsulko.com>

Looks good! Wonder why didn't we do this sooner! ;)

Acked-by: Robert Nelson <robertcnelson@gmail.com>

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
