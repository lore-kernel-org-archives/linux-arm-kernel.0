From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 13 Oct 2011 11:15:39 +0200
Subject: [RFC 1/5] ARM: dev_archdata: add private iommu extension
In-Reply-To: <CAK=Wgba6xxD2DBJhM--AcTPBoNRiOZ_6f8+j3bfaCqZMO8A4+w@mail.gmail.com>
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
	<1316948337-7924-2-git-send-email-ohad@wizery.com>
	<CAK=Wgba6xxD2DBJhM--AcTPBoNRiOZ_6f8+j3bfaCqZMO8A4+w@mail.gmail.com>
Message-ID: <CAK=Wgbau+XZ-c21FCT8DT0NYfm2uD6WZv3=cU2R23pV7LUkxEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 5, 2011 at 11:26 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Russell,
>
> On Sun, Sep 25, 2011 at 1:58 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Add a private iommu pointer to the ARM-specific arch data in the
>> device struct, which will be used to attach iommu-specific data
>> to devices which require iommu support.
>
> Can you please take a look and ack/nack ?

gentle reminder
