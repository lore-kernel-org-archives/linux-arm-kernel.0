From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 04 Jun 2013 17:51:41 +0200
Subject: Planning the merge of KVM/arm64
In-Reply-To: <CAMJs5B9PxHfUrugov4HJknQ24fG7MNp8obziqu9dnSztsGBksQ@mail.gmail.com>
References: <51ADDDAE.4040705@arm.com>
 <CAMJs5B_PB1pNVCO_EK7aTghN23L+d0RovAFi7inrVsJb5STWOA@mail.gmail.com>
 <51AE00D7.9030607@arm.com> <51AE082C.6050907@redhat.com>
 <CAMJs5B9PxHfUrugov4HJknQ24fG7MNp8obziqu9dnSztsGBksQ@mail.gmail.com>
Message-ID: <51AE0D0D.3030106@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 04/06/2013 17:43, Christoffer Dall ha scritto:
> Hi Paolo,
> 
> I don't think this is an issue. Gleb and Marcelo for example pulled
> RMK's stable tree for my KVM/ARM updates for the 3.10 merge window and
> that wasn't an issue.  If Linus pulls the kvm/next tree first the
> diffstat should be similar and everything clean enough, no?
> 
> Catalin has previously expressed his wish to upstream the kvm/arm64
> patches directly through him given the churn in a completely new
> architecture and he wants to make sure that everything looks right.
> 
> It's a pretty clean implementation with quite few dependencies and
> merging as a working series should be a priority instead of the
> Kconfig hack, imho.

Ok, let's see what Gleb says.

Paolo
