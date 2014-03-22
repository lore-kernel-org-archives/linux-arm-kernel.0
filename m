From: pbonzini@redhat.com (Paolo Bonzini)
Date: Sat, 22 Mar 2014 20:57:58 +0100
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140322122354.7644FC418C4@trevor.secretlab.ca>
References: <20140226183454.GA14639@cbox> <20140301152756.67A02C40238@trevor
 .secretlab.ca> <20140306085213.GU643@mal.justgohome.co.uk> <531843EE.
 8040102@redhat.com> <53185FB9.1040308@redhat.com> <20140306120449.GA29916@
 mal.justgohome.co.uk> <20140307122418.2F2C4C408EC@trevor.secretlab.ca> <
 20140322010206.GF25519@cbox> <20140322122354.7644FC418C4@trevor.secretlab.ca>
Message-ID: <532DEB46.3040107@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 22/03/2014 13:23, Grant Likely ha scritto:
> VM implementations SHOULD to implement persistent variables for
> their UEFI implementation - with whatever constraints that may be put on
> higher level tools. Variable storage SHALL be a property of a VM
> instance, but SHALL NOT be stored as part of a portable disk image.
> Portable disk images SHALL conform to the UEFI removable disk
> requirements from the UEFI spec.

I fully agree with this wording.

Paolo
