From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 28 Sep 2015 09:04:28 +0200
Subject: [linux-sunxi] Re: [PATCH] musb: sunxi: Ignore VBus errors in
 host-only mode
In-Reply-To: <jwvmvw7zzg5.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
References: <1438723553-4136-1-git-send-email-hdegoede@redhat.com>
 <55C31963.2010701@schinagl.nl> <55C3709C.4080609@redhat.com>
 <55C47041.3000603@schinagl.nl> <55E93D8C.9020804@schinagl.nl>
 <55F1CA9B.3070204@redhat.com> <5606948A.5040200@schinagl.nl>
 <jwvmvw7zzg5.fsf-monnier+gmane.comp.hardware.netbook.arm.sunxi@gnu.org>
Message-ID: <5608E67C.1040003@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-09-15 16:58, Stefan Monnier wrote:
>> &usbphy {
>>      /* Unset otg detect pins as we force dr_mode */
>>      /delete-property/ usb0_id_det-gpio;
>>      /delete-property/ usb0_vbus_det-gpio;
>> };
>
> Side question [ wearing my "contributor to Emacs's dts-mode" hat ]:
>
> How should this piece of syntax be parsed?  Is
>
>        /<something>/ blabla;
>
> a general syntax accepted in DTS files, with various possible
> <something> in there?  Could someone point me to some documentation
> explaining/describing this syntax?

It is probably best to start a new thread about this on <devicetree@vger.kernel.org>,
that way people who may actually know the answer will see the mail :)

Regards,

Hans
