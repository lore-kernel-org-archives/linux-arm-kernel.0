From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 11 Feb 2016 08:50:41 -0600
Subject: [PATCH v10 3/8] dt, numa: adding numa dt binding implementation.
In-Reply-To: <1454407763-1017-4-git-send-email-gkulkarni@caviumnetworks.com>
References: <1454407763-1017-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1454407763-1017-4-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <CAL_JsqK5HV9yzBE+ANnTw26eVR7Dy+B8OkwQ-7WF8KDa86Fd9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 4:09 AM, Ganapatrao Kulkarni
<gkulkarni@caviumnetworks.com> wrote:
> dt node parsing for numa topology is done using device property
> numa-node-id and device node distance-map.

How is it that powerpc doesn't need flat DT parsing for NUMA? Both
arches are memblock based and the binding is similar IIRC, so you
should be able to find a way to do this with the unflattened tree.
Ideally, there should be some common code shared as well.

Do you have a git tree with this series?

Rob
