From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 25 Mar 2015 11:56:08 +0100
Subject: ARM: KVM/XEN: how should we support virt-what?
In-Reply-To: <20150325094440.GB3163@hawk.usersys.redhat.com>
References: <20150325094440.GB3163@hawk.usersys.redhat.com>
Message-ID: <55129448.6000200@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/03/2015 10:44, Andrew Jones wrote:
> 2) create a specific DT node that will get exposed through sysfs, or
>    somewhere.

Looking at custom DT nodes is what PowerPC does.

Paolo
