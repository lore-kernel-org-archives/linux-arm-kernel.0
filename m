From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 29 Dec 2011 08:53:48 +0200
Subject: [RESENDx2] [PULL] virtio: fix barriers for virtio-mmio
In-Reply-To: <87y5twf16x.fsf@rustcorp.com.au>
References: <8739cbkgv2.fsf@rustcorp.com.au>
 <CA+55aFyvMkAtXPRxiFR+UpZKGHMhp8Vd9aYg1dkaoKMwD5MLcw@mail.gmail.com>
 <CA+55aFzKU0GWqpQo2AzAawoVm=qPaJiwKTcifeYApyZP_Hj3nQ@mail.gmail.com>
 <CAK=WgbacH1tXHJiHNKLNNsFA7-vnFT_J6vYOANh0wzGyUj8Zpg@mail.gmail.com>
 <87y5twf16x.fsf@rustcorp.com.au>
Message-ID: <CAK=WgbZzhFS3tTpywN2HUdjmpTuWSqg9BCC9=QaO10=d_ACRiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 6:31 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> OK, I've applied this patch; you might want to carry it in your tree
> too. ?You'll need to fix up your call to vring_new_virtqueue()....

Will do. Thanks !
